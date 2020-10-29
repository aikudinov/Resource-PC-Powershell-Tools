# Create Telnet Client and connect to Blue Prism HTTP Server as Admin
$telnet = New-TelnetClient
$telnet.SendCommand('user name admin')
$telnet.SendCommand('password 2020$BP668160#')
$telnet.GetOutput()
$telnet.GetOutput()
$telnet.SendCommand('userlist')
$telnet.GetOutput()
# Should return
# List of users. 1 per line in the format GUID - Username
# this provides you with the userid of the user you want to use when executing the GetAuthToken command.