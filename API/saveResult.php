<?php
include 'config.php';

// Kết nối tới CSDL
$conn = sqlsrv_connect($serverName, $connectionOptions);

if ($conn === false) {
	die(print_r(sqlsrv_errors(), true));
}

$results = array();
$responses = array(); // Khởi tạo mảng phản hồi

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	$data = json_decode(file_get_contents('php://input'), true);
	if (isset($data['results'])) {
		$results = $data['results'];
		// Tiếp tục xử lý danh sách $results ở bước tiếp theo

		// Lưu dữ liệu từ danh sách `results` vào cơ sở dữ liệu
		foreach ($results as $result) {
			// Kiểm tra và chuyển đổi kiểu dữ liệu nếu cần thiết
			$cccd = isset($result['cccd']) ? (String)$result['cccd'] : null;
			$idSuvey = isset($result['idSurvey']) ? (string)$result['idSurvey'] : null;
			$idQuestion = isset($result['idQuestion']) ? (string)$result['idQuestion'] : null;
			$answer = isset($result['answer']) ? (string)$result['answer'] : null;

			// Câu lệnh SQL để chèn dữ liệu vào bảng
			$sql = "INSERT INTO result (idUser, id_survey, id_question, answer_text) VALUES (?, ?, ?, ?)";
			$params = array($cccd, $idSuvey, $idQuestion, $answer);

			// Thực thi câu lệnh SQL
			$stmt = sqlsrv_prepare($conn, $sql, $params);

			// Kiểm tra thành công và thêm phản hồi vào mảng
			if (sqlsrv_execute($stmt)) {
				// Thêm phản hồi thành công vào mảng
				$responses[] = ['status' => 'success', 'message' => 'Data saved successfully'];
			} else {
				// Thêm phản hồi lỗi vào mảng
				$responses[] = ['status' => 'error', 'message' => 'Failed to save database'];
			}
		}
		// Trả về phản hồi dưới dạng JSON
		echo json_encode($responses);
		sqlsrv_close($conn);
	}
}
?>

