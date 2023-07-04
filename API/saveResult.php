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

        // Xóa dữ liệu cũ dựa vào $cccd và $idSuvey
        $cccd = isset($results[0]['cccd']) ? (string)$results[0]['cccd'] : null;
        $idSuvey = isset($results[0]['idSurvey']) ? (string)$results[0]['idSurvey'] : null;

        // Câu lệnh SQL để xóa dữ liệu cũ
        $sqlDelete = "DELETE FROM result WHERE idUser = ? AND id_survey = ?";
        $paramsDelete = array($cccd, $idSuvey);

        // Thực thi câu lệnh SQL xóa dữ liệu cũ
        $stmtDelete = sqlsrv_prepare($conn, $sqlDelete, $paramsDelete);
        if (sqlsrv_execute($stmtDelete)) {
            // Tiếp tục xử lý danh sách $results ở bước tiếp theo

            // Lưu dữ liệu từ danh sách `results` vào cơ sở dữ liệu
            foreach ($results as $result) {
                // Kiểm tra và chuyển đổi kiểu dữ liệu nếu cần thiết
                $cccd = isset($result['cccd']) ? (string)$result['cccd'] : null;
                $idSuvey = isset($result['idSurvey']) ? (string)$result['idSurvey'] : null;
                $idQuestion = isset($result['idQuestion']) ? (string)$result['idQuestion'] : null;
                $answer = isset($result['answer']) ? (string)$result['answer'] : null;

                // Câu lệnh SQL để chèn dữ liệu vào bảng
                $sqlInsert = "INSERT INTO result (idUser, id_survey, id_question, answer_text) VALUES (?, ?, ?, ?)";
                $paramsInsert = array($cccd, $idSuvey, $idQuestion, $answer);

                // Thực thi câu lệnh SQL chèn dữ liệu mới
                $stmtInsert = sqlsrv_prepare($conn, $sqlInsert, $paramsInsert);

                // Kiểm tra thành công và thêm phản hồi vào mảng
                if (sqlsrv_execute($stmtInsert)) {
                    // Thêm phản hồi thành công vào mảng
                    $responses[] = ['status' => 'success', 'message' => 'Data saved successfully'];
                } else {
                    // Thêm phản hồi lỗi vào mảng
                    $responses[] = ['status' => 'error', 'message' => 'Failed to save database'];
                }
            }
        } else {
            // Thêm phản hồi lỗi vào mảng
            $responses[] = ['status' => 'error', 'message' => 'Failed to delete old data'];
        }

        // Trả về phản hồi dưới dạng JSON
        echo json_encode($responses);
        sqlsrv_close($conn);
    }
}
?>

