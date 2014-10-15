echo off
REM set /P remoteip=enter IP or name of host (note you must be admin on this box):
REM Set /P computername2=Enter the store number:
REM Set /P id=Enter your user ID:
REM Set /P pass=Enter your Password:
REM Set /P freedrive=Enter a Free Drive Letter on your computer (E-Z):
cls
#Set /P  blah =Don't forget to copy the local security policy @ c:\%computername%_local_sec_policy.txt 
[Hit Enter]
cls

REM Net use %freedrive%: \\%computername%\c$

echo Host: %computername%>%computername%_report.txt
echo Host Review Results>>%computername%_report.txt
echo=================================================================>>%computername%_report.txt

echo.>>%computername%_report.txt
ver >>%computername%_report.txt
ipconfig /all>>%computername%_report.txt
echo.>>%computername%_report.txt

echo =================================================================================>>%computername%_report.txt
echo.>>%computername%_report.txt
netstat -an |find /i "listening">>%computername%_report.txt
echo.>>%computername%_report.txt
echo =================================================================================>>%computername%_report.txt
echo.>>%computername%_report.txt

echo.>>%computername%_report.txt
net share>>%computername%_report.txt
echo.>>%computername%_report.txt

echo =================================================================================>>%computername%_report.txt

echo.>>%computername%_report.txt


REM get screen saver settings
REM echo Screen Saver Settings>>%computername%_report.txt
REM echo.>>%computername%_report.txt
reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Control Panel\Desktop" /s>>%computername%_report.txt

echo =================================================================================>>%computername%_report.txt

echo.>>%computername%_report.txt
echo NTP Settings>>%computername%_report.txt
echo.>>%computername%_report.txt
w32tm /query /source>>%computername%_report.txt
w32tm /dumpreg /subkey:parameters>>%computername%_report.txt
echo.>>%computername%_report.txt

echo =================================================================================>>%computername%_report.txt
Net time /querysntp>>%computername%_report.txt
echo =================================================================================>>%computername%_report.txt

REM get audit policies
echo.>>%computername%_report.txt
echo Audit Policies>>%computername%_report.txt
echo.>>%computername%_report.txt
auditpol /get /category:* >>%computername%_report.txt


echo =================================================================================>>%computername%_report.txt
echo.>>%computername%_report.txt
echo.>>%computername%_report.txt
REM tasklist >>%computername%_report.txt
echo =================================================================================>>%computername%_report.txt

dumpsec.exe /computer=\\%computername% /rpt=policy /saveas=tsv /outfile=%computername%_policies.txt
echo.>>%computername%_report.txt
dumpsec.exe /computer=\\%computername% /rpt=shares /saveas=tsv /outfile=%computername%_shares.txt
dumpsec.exe /computer=\\%computername% /rpt=rights /saveas=tsv /outfile=%computername%_rights.txt

echo Admins >>%computername%_report.txt
echo.>>%computername%_report.txt

net localgroup administrators >>%computername%_report.txt
net accounts >>%computername%_report.txt

echo.>>%computername%_report.txt
echo.>>%computername%_report.txt
REM net start >>%computername%_report.tx


REM Get the local security policy
SecEdit /export /cfg c:\%computername%_local_sec_policy.txt

REM Get Users in detail
dumpsec.exe /computer=\\%computername% /rpt=users /saveas=tsv /outfile=%computername%_users.xls

echo =================================================================================>>%computername%_report.txt
REM cscript pass.vbs >>%computername%_report.txt
echo =================================================================================>>%computername%_report.txt
REM net use \\localhost\c$ /u:administrator "" >>%computername%_report.txt
REM net use \\localhost\c$ /u:guest "" >>%computername%_report.txt

echo =================================================================================>>%computername%_report.txt
echo =================================================================================>>%computername%_report.txt
echo =================================================================================>>%computername%_report.txt
type c:\%computername%_local_sec_policy.txt >>%computername%_report.txt
