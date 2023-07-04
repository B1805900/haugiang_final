<?php
include 'config.php';

// Kết nối tới CSDL
$conn = sqlsrv_connect($serverName, $connectionOptions);

if ($conn === false) {
	die(print_r(sqlsrv_errors(), true));
}

$responses = array(); // Khởi tạo mảng phản hồi

// Kiểm tra phương thức gửi request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$data = json_decode(file_get_contents("php://input"));
	$cccd = isset($data->cccd) ? (string) $data->cccd : '';
	$fullname = isset($data->fullname) ? (string) $data->fullname : '';
	$phone = isset($data->phone) ? (string) $data->phone : '';
	$address = isset($data->address) ? (string) $data->address : '';
	$email = isset($data->email) ? (string) $data->email : '';
	$age = isset($data->age) ? intval($data->age) : 0;
	$gender = isset($data->gender) ? (string) $data->gender : '';
	$nation = isset($data->nation) ? (string) $data->nation : '';
	$education = isset($data->education) ? (string) $data->education : '';
	$numpeople = isset($data->numpeople) ? intval($data->numpeople) : 0;
	$numfemale = isset($data->numfemale) ? intval($data->numfemale) : 0;
	$job = isset($data->job) ? (string) $data->job : '';
	$income = isset($data->income) ? (string) $data->income : '';
	$usedservice = isset($data->usedservice) ? (string) $data->usedservice : '';

	// Kiểm tra xem người dùng đã tồn tại hay chưa
	$sqlCheckUser = "SELECT idUser FROM users WHERE cccd = ?";
	$paramsCheckUser = array($cccd);
	$stmtCheckUser = sqlsrv_prepare($conn, $sqlCheckUser, $paramsCheckUser);
	if (sqlsrv_execute($stmtCheckUser)) {
		// Nếu người dùng đã tồn tại, cập nhật thông tin
		if (sqlsrv_has_rows($stmtCheckUser) && !empty($cccd)) {
			$sqlUpdate = "UPDATE users SET fullname = ?, phone = ?, address = ?, email = ?, age = ?, gender = ?, nation = ?, education = ?, numpeople = ?, numfemale = ?, job = ?, income = ?, usedservice = ? WHERE cccd = ?";
			$paramsUpdate = array($fullname, $phone, $address, $email, $age, $gender, $nation, $education, $numpeople, $numfemale, $job, $income, $usedservice, $cccd);
			$stmtUpdate = sqlsrv_prepare($conn, $sqlUpdate, $paramsUpdate);

			if (sqlsrv_execute($stmtUpdate)) {
				// Lấy giá trị idUser sau khi cập nhật
				$sqlGetId = "SELECT idUser FROM users WHERE cccd = ?";
				$paramsGetId = array($cccd);
				$stmtGetId = sqlsrv_query($conn, $sqlGetId, $paramsGetId);

				if ($stmtGetId !== false) {
					$newId = null;
					while ($row = sqlsrv_fetch_array($stmtGetId, SQLSRV_FETCH_ASSOC)) {
						$newId = $row['idUser'];
					}

					if ($newId !== null) {
						// Thêm phản hồi thành công vào mảng
						$responses[] = ['status' => 'success', 'message' => 'Data updated successfully', 'newId' => $newId];
					} else {
						// Thêm phản hồi lỗi vào mảng
						$responses[] = ['status' => 'error', 'message' => 'Failed to get new id'];
					}
				} else {
					// Thêm phản hồi lỗi vào mảng
					$responses[] = ['status' => 'error', 'message' => 'Failed to get id after update'];
				}
			} else {
				// Thêm phản hồi lỗi vào mảng
				$responses[] = ['status' => 'error', 'message' => 'Failed to update database'];
			}
		} else {
			// Người dùng chưa tồn tại, thực hiện thêm mới
			$sqlInsert = "INSERT INTO users (cccd, fullname, phone, address, email, age, gender, nation, education, numpeople, numfemale, job, income, usedservice) OUTPUT INSERTED.idUser VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			$paramsInsert = array($cccd, $fullname, $phone, $address, $email, $age, $gender, $nation, $education, $numpeople, $numfemale, $job, $income, $usedservice);
			$stmtInsert = sqlsrv_prepare($conn, $sqlInsert, $paramsInsert);

			if (sqlsrv_execute($stmtInsert)) {
				// Lấy giá trị idUser từ câu lệnh INSERT
				$newId = null;
				while ($row = sqlsrv_fetch_array($stmtInsert, SQLSRV_FETCH_ASSOC)) {
					$newId = $row['idUser'];
				}

				if ($newId !== null) {
					// Thêm phản hồi thành công vào mảng
					$responses[] = ['status' => 'success', 'message' => 'Data saved successfully', 'newId' => $newId];
				} else {
					// Thêm phản hồi lỗi vào mảng
					$responses[] = ['status' => 'error', 'message' => 'Failed to get new id'];
				}
			} else {
				// Thêm phản hồi lỗi vào mảng
				$responses[] = ['status' => 'error', 'message' => 'Failed to save database'];
			}
		}
	} else {
		// Thêm phản hồi lỗi vào mảng
		$responses[] = ['status' => 'error', 'message' => 'Failed to check existing user'];
	}

	echo json_encode($responses);

	// Đóng kết nối cơ sở dữ liệu
	sqlsrv_close($conn);
}
?>
