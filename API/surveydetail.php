<?php
include 'config.php';

if (isset($_GET['id_survey']) && isset($_GET['idUser'])) {
    $id = urldecode($_GET['id_survey']);
	$idUser = urldecode($_GET['idUser']);
    $conn = sqlsrv_connect($serverName, $connectionOptions);

    if ($conn === false) {
        die(print_r(sqlsrv_errors(), true));
    }
	
	// Lấy danh sách cặp (id_question, answer_content) đã xuất hiện trong bảng kết quả
	$query = "SELECT id_question, answer_text FROM result WHERE id_survey = ? AND idUser = ?";
	$params = array($id, $idUser);
	$result_answers = sqlsrv_query($conn, $query, $params);

	if ($result_answers === false) {
		die(print_r(sqlsrv_errors(), true));
	}

	$answered_values = array();

	while ($row_answer = sqlsrv_fetch_array($result_answers, SQLSRV_FETCH_ASSOC)) {
		$answered_values[] = array(
			'id_question' => $row_answer['id_question'],
			'answer_text' => $row_answer['answer_text']
		);
	}

	
	

    $query = "SELECT id_group, group_name FROM groupquestion WHERE id_survey = ?";
    $params = array($id);
    $result = sqlsrv_query($conn, $query, $params);

    if ($result === false) {
        die(print_r(sqlsrv_errors(), true));
    }

    $group = array();

    while ($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC)) {
        $id_group = $row['id_group'];
        $group_name = $row['group_name'];

        $query = "SELECT id_question, contents, type FROM question WHERE id_group = ?";
        $params = array($id_group);
        $result_question = sqlsrv_query($conn, $query, $params);

        if ($result_question === false) {
            die(print_r(sqlsrv_errors(), true));
        }

        $data = array();

        while ($row_question = sqlsrv_fetch_array($result_question, SQLSRV_FETCH_ASSOC)) {
            $id_question = $row_question['id_question'];
            $question_content = $row_question['contents'];
			$type = $row_question['type'];
            $query = "SELECT contents, moveto FROM answer WHERE id_question = ?";
            $params = array($id_question);
            $result_answer = sqlsrv_query($conn, $query, $params);

            if ($result_answer === false) {
                die(print_r(sqlsrv_errors(), true));
            }

            $answers = array();
			$moveto = array();	
			
			
			$datanew = array();
			while ($row_answer = sqlsrv_fetch_array($result_answer, SQLSRV_FETCH_ASSOC)) {
				$answer_content = $row_answer['contents'];
				$moveto_value = $row_answer['moveto'];

				$is_checked = false;

				foreach ($answered_values as $answered_value) {
					if ($answered_value['id_question'] == $id_question && $answered_value['answer_text'] == $answer_content) {
						$is_checked = true;
						break;
					}
				}

				$datanew[] = array(
					'answer' => $answer_content,
					'moveto' => $moveto_value,
					'isCheck' => $is_checked
				);
			}


            $data[] = array(
                'id_question' => $id_question,
                'question' => $question_content,
                'answers' => $datanew,
                'type' => $type
            );
        }

        $group[] = array(
            'id_group' => $id_group,
            'group_name' => $group_name,
            'questions' => $data
        );
    }

    echo json_encode($group);
}
?>
