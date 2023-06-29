<?php
include 'config.php';

if (isset($_GET['id_survey'])) {
    $id = urldecode($_GET['id_survey']);
    $conn = sqlsrv_connect($serverName, $connectionOptions);

    if ($conn === false) {
        die(print_r(sqlsrv_errors(), true));
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

        $query = "SELECT id_question, contents FROM question WHERE id_group = ?";
        $params = array($id_group);
        $result_question = sqlsrv_query($conn, $query, $params);

        if ($result_question === false) {
            die(print_r(sqlsrv_errors(), true));
        }

        $data = array();

        while ($row_question = sqlsrv_fetch_array($result_question, SQLSRV_FETCH_ASSOC)) {
            $id_question = $row_question['id_question'];
            $question_content = $row_question['contents'];

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
                $answers[] = $row_answer['contents'];
				$moveto[] = $row_answer['moveto'];
				$datanew[] = array(
                'answer' => $row_answer['contents'],
                'moveto' => $row_answer['moveto'],
				'isCheck' => false,
				);
            }

            $data[] = array(
                'id_question' => $id_question,
                'question' => $question_content,
                'answers' => $datanew,
                'type' => 1
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
