# Create Telnet Client and connect to Blue Prism HTTP Server as Admin
$telnet = New-TelnetClient
$telnet.SendCommand('user name admin')
$telnet.SendCommand('password your password')
$telnet.GetOutput()
$telnet.GetOutput()
# Should return
# USER SET
# USER AUTHENTICATED

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

# the text output from the telnet needs to be cleaned up before it can be used.
$telnet.SendCommand('status')
$pendingsessions = $telnet.GetOutput()
$pendingsessions = $pendingsessions.Replace('RESOURCE UNIT','')
$pendingsessions = $pendingsessions.Replace(' - PENDING ','')
$pendingsessions = $pendingsessions.Trim()
$pendingsessions = $pendingsessions.Replace([char]$pendingsessions[37],',')
$pendingsessions = $pendingsessions.Remove($pendingsessions.IndexOf('Total running:')-1)
$sessionsarray = $pendingsessions.Split(',')
# We are left with an array of session ID's.

ForEach ($s in $sessionsarray)
    {
       $row = $data.Tables[0].Where({$_.Item("sessionid") -eq $s})
       $processid = $row.Item(0).Item(0)
       'Process ID='+$processid
       $tokencmd = 'getauthtoken '+$processid+' <your user ID> <your password>'
       $telnet.SendCommand($tokencmd)
       Start-Sleep -Seconds 5
       $authtoken = $telnet.GetOutput()       
       'Auth Token='+$authtoken
       $deletecmd = 'deleteas '+$authtoken.Trim()+' '+$s.Trim()
       'Delete Command='+$deletecmd
       $telnet.SendCommand($deletecmd)
       Start-Sleep -Seconds 5
       'Result='+$telnet.GetOutput()
    }

$telnet.SendCommand("status")
$telnet.GetOutput()

