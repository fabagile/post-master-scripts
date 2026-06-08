$src = "\\appli-prod01\appli$\Calimero\MAJ TNSNAMES\tnsnames.ora"
$target = "C:\oracle\product\11.2.0\client_1\network\admin\tnsnames.ora"
Copy-Item -Path $src -Destination $target -Force
# get-childitem $src
