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
	$cccd = (string) $data->cccd;
	$fullname = (string) $data->fullname;
	$phone = (string) $data->phone;
	$address = (string) $data->address;
	$email = (string) $data->email;
	$age = intval($data->age);
	$gender = (string) $data->gender;
	$nation = (string) $data->nation;
	$education = (string) $data->education;
	$numpeople = intval($data->numpeople);
	$numfemale = intval($data->numfemale);
	$job = (string) $data->job;
	$income = (string) $data->income;
	$usedservice = (string) $data->usedservice;

	// Câu lệnh SQL INSERT để lưu đối tượng vào cơ sở dữ liệu
	$sql = "INSERT INTO users (cccd, fullname, phone, address, email, age, gender, nation, education, numpeople, numfemale, job, income, usedservice) OUTPUT INSERTED.idUser VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	$params = array($cccd, $fullname, $phone, $address, $email, $age, $gender, $nation, $education, $numpeople, $numfemale, $job, $income, $usedservice);
	$stmt = sqlsrv_prepare($conn, $sql, $params);

	if (sqlsrv_execute($stmt)) {
		// Lấy giá trị idUser từ câu lệnh INSERT
		$newId = null;
		while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
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

	echo json_encode($responses);

	// Đóng kết nối c


// Đóng kết nối cơ sở dữ liệu
	sqlsrv_close($conn);
	
}
?>

