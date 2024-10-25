# Executa o comando DISM para restaurar a integridade da imagem
Write-Host "Executando DISM..."
Start-Process -FilePath "dism.exe" -ArgumentList "/online", "/cleanup-image", "/restorehealth" -Wait

# Executa o comando SFC para verificar e reparar arquivos de sistema corrompidos
Write-Host "Executando SFC..."
Start-Process -FilePath "sfc.exe" -ArgumentList "/scannow" -Wait

# Executa o comando CHKDSK para verificar o disco
Write-Host "Executando CHKDSK..."
Start-Process -FilePath "chkdsk.exe" -ArgumentList "/f", "/r" -Wait

# Verifica se há drivers corrompidos ou desatualizados
Write-Host "Verificando drivers corrompidos ou desatualizados..."
Start-Process -FilePath "pnputil.exe" -ArgumentList "/enum-drivers" -Wait

# Limpa arquivos temporários que podem estar corrompidos e causar problemas
Write-Host "Limpando arquivos temporários..."
Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "cleanmgr /sagerun:1" -Wait

# Atualiza drivers via Windows Update
Write-Host "Atualizando drivers e sistema via Windows Update..."
Start-Process -FilePath "powershell.exe" -ArgumentList "-Command", "Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot" -Wait

# Verifica se há problemas de integridade no registro do Windows
Write-Host "Verificando integridade do registro..."
Start-Process -FilePath "dism.exe" -ArgumentList "/online", "/cleanup-image", "/scanhealth" -Wait

# Limpa os logs de erros antigos no Visualizador de Eventos
Write-Host "Limpando logs antigos do Visualizador de Eventos..."
wevtutil el | Foreach-Object { wevtutil cl $_ }

# Restaura configurações de rede (útil se o problema estiver relacionado à rede)
Write-Host "Redefinindo configurações de rede..."
Start-Process -FilePath "netsh" -ArgumentList "winsock reset" -Wait
Start-Process -FilePath "netsh" -ArgumentList "int ip reset" -Wait

Write-Host "By João Victor S.S."
