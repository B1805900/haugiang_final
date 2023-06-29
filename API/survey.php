<?php
include 'config.php';

class MyObject {
    public $id_survey;
    public $name_survey;
	public $time_create;
	public $time_end;
	public $username;
    
    public function __construct($value1, $value2, $value3, $value4, $value5) {
        $this->id_survey = $value1;
        $this->name_survey = $value2;
		$this->time_create = $value3;
		$this->time_end = $value4;
		$this->username = $value5;
    }
}

// Kết nối đến SQL Server
$conn = sqlsrv_connect($serverName, $connectionOptions);

if ($conn === false) {
    die(print_r(sqlsrv_errors(), true));
}

// Thực hiện một truy vấn
$sql = "SELECT * FROM survey";
$query = sqlsrv_query($conn, $sql);

if ($query === false) {
    die(print_r(sqlsrv_errors(), true));
}

// Xử lý kết quả truy vấn
while ($row = sqlsrv_fetch_array($query, SQLSRV_FETCH_ASSOC)) {
	$myObject = new MyObject($row['id_survey'],$row['name_survey'],$row['time_create'],$row['time_end'],$row['username']);
	echo json_encode($myObject);
}

// Đóng kết nối
sqlsrv_close($conn);

?>
