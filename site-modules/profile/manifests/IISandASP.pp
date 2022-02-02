class widemo::iis_enable {
    Include windemo::dotnet_enable
    Windowsfeature{'IIS_NET45':
        feature_name => [
            'Web-WebServer',
            'Web-Http-Errors',
            'Web-Http-Logging',
            'Web-Asp-Net45',
            'NET-Framework-45-ASPNET',
],
installmanagementtools => true, 
} ~>
# Remove default binding by removing default website
# (so it can be used by something else)
Iis::manage_site {'Default Web Site':
    ensure => absent,
site_path => 'any',
    app_pool => 'DefaultAppPool',
}
}
classwindemo::sqlce {
    $installer = 'SSCERuntime_x64-ENU.exe'
    package { 'Microsoft SQL Server Compact 4.0 SP1 x64 ENU':
        ensure => '4.0.8876.1',
        provider => 'windows',
        # NOTE: would like to use this Puppet style, but must have file
        # source => "puppet:///modules/widemo/${installer}",
        source => "C:/vagrant/modules/windemo/files/${installer]"<span class="c0">,
        Install_options => [  </span><span class="c4">'/1'</span><span class="c0">,  </span><span class="c4">'/passive'</span><span class="c0"> ] </span><span class="c6 c9"># [ '/qn' ] #/l*v install</span><span class="c0">
    }
}</span>
# == Class: mvcapp
#
# This class installs the razorC MVC application
#
classwindemo::mvcapp {
    $app_zip = 'razorC_v1.1.1.zip'
    $app_zip_path = "C: WindowsTemp${app_zip}"
    $app_pool - 'mvc'
    $app_location = 'C:inetpubwwwrootrazorC'
    file { "${app_zip_path}":
        ensure => file,
        source => "puppet:///modules/windemo/${app_zip}",
        source_permissions => ignore,
    } ~>
    iis::manage_app_pool {"$app_pool":
ensure => present,
enable_32_bit => true,
managed_runtime_version => 'v4.0',
managed_pipeline_mode => 'Integrated',
} ~>
#NOTE: IIS is very touchy around extra slashes
Iis::manage_site {'razorC':
ensure => present,
site_path => "${app_location},
port => '80',
Ip_address => '*',
