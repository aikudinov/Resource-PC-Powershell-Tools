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













