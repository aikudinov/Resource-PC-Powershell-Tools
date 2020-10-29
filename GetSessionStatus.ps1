$sqlConn = New-Object System.Data.SqlClient.SqlConnection
$sqlConn.ConnectionString = "Server=localhost\SQLEXPRESS;Integrated Security=True; Initial Catalog=BluePrism"
$query = "select p.processid,p.name,s.sessionid from BPAprocess p, BPASession s where s.processid = p.processid and s.statusid=0"
$sqlCmd = New-Object System.Data.SqlClient.SqlCommand
$sqlCmd.Connection = $sqlConn
$sqlCmd.CommandText = $query
$adp = New-Object System.Data.SqlClient.SqlDataAdapter $sqlCmd
$data = New-Object System.Data.DataSet
$sqlConn.Open()
$adp.Fill($data) | Out-Null
$sqlConn.Close()
$data.Tables[0]
