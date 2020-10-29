# Create Telnet Client and connect to Blue Prism HTTP Server as Admin
$telnet = New-TelnetClient
$telnet.SendCommand('user name admin')
$telnet.SendCommand('password 2020$BP668160#')
$telnet.GetOutput()
$telnet.GetOutput()
# Should return
# USER SET
# USER AUTHENTICATED


