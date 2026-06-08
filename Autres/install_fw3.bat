copy "\\mdt-prod01\f$\MDT_SEMITAN\Operating Systems\OS\sxs\*"  "c:\temp\sxs"
DISM /online /Enable-Feature /FeatureName:NetFx3 /All /Source:c:\temp\sxs /LimitAccess