# Set table grid
set-table-grid `
	-grid $rdsGrid `
	-accounts $config.rds `
	-cols 7;

# Set header
set-header `
	-grid $rdsGrid  `
	-name "rds_ConnectHeader" `
	-content "Aws RDS connections via SSM" `
	-background "LightSlateGray" `
	-width 750;

# Set sub header
set-sub-header `
    -grid $rdsGrid `
	-names @("rds_ConnectSubHeaderName", "rds_ConnectSubHeaderPort", "rds_ConnectSubHeaderInstance", "rds_ConnectSubHeaderCluster","rds_ConnectSubHeaderReader1", "rds_ConnectSubHeaderReader2", "rds_ConnectSubHeaderWriter") `
    -content @("Name", "Port", "Instance", "Cluster", "Reader1", "Reader2", "Writer") `
    -thickness @("1,1,1,1", "0,1,0,1", "1,1,0,1", "1,1,0,1", "1,1,0,1", "1,1,0,1", "1,1,0,1") `
    -cols 7 `
    -row 2 `
	-width @(106, 106, 106, 106, 107, 107, 107) `

set-data `
	-grid $rdsGrid `
	-accounts $config.rds `
	-names @("rds_ConnectLabelName", "rds_ConnectLabelPort", "rds_ConnectLabelInstance", "rds_cluster", "rds_reader1", "rds_reader2", "rds_writer") `
	-thickness @("1,1,1,1", "0,1,0,1", "1,1,0,1", "1,1,0,1", "1,1,0,1", "1,1,0,1", "1,1,0,1") `
	-cols 7 `
	-width @(106, 106, 106, 106, 107, 107, 107) `
	-foreground @("#FF5A5B65", "Green", "Green", "#FF5A5B65", "#FF5A5B65", "#FF5A5B65", "#FF5A5B65");
    