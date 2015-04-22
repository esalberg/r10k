# This class configures r10k
class r10k (
  $remote                    = $r10k::params::remote,
  $sources                   = $r10k::params::sources,
  $purgedirs                 = $r10k::params::r10k_purgedirs,
  $cachedir                  = $r10k::params::r10k_cache_dir,
  $configfile                = $r10k::params::r10k_config_file,
  $git_provider              = $r10k::params::git_provider,
  $git_private_key           = $r10k::params::git_private_key,
  $git_username              = $r10k::params::git_username,
  $version                   = $r10k::params::version,
  $modulepath                = $r10k::params::modulepath,
  $manage_modulepath         = $r10k::params::manage_modulepath,
  $manage_ruby_dependency    = $r10k::params::manage_ruby_dependency,
  $r10k_basedir              = $r10k::params::r10k_basedir,
  $package_name              = $r10k::params::package_name,
  $provider                  = $r10k::params::provider,
  $gentoo_keywords           = $r10k::params::gentoo_keywords,
  $install_options           = $r10k::params::install_options,
  $mcollective               = $r10k::params::mcollective,
  $manage_configfile_symlink = $r10k::params::manage_configfile_symlink,
  $configfile_symlink        = $r10k::params::configfile_symlink,
  $include_prerun_command    = false,
  $include_postrun_command   = false,
) inherits r10k::params {

  $ruby_dependency_options=['include','declare','ignore']
  validate_re($manage_ruby_dependency,$ruby_dependency_options)

  # TODO: Clean this up when 3.0 to require a boolean
  if $include_prerun_command == true  or $include_prerun_command == 'true'{
    include r10k::prerun_command
  }

  if $include_postrun_command == true  or $include_postrun_command == 'true'{
    include r10k::postrun_command
  }


  class { 'r10k::install':
    install_options        => $install_options,
    keywords               => $gentoo_keywords,
    manage_ruby_dependency => $manage_ruby_dependency,
    package_name           => $package_name,
    provider               => $provider,
    version                => $version,
  }

  class { 'r10k::config':
    cachedir                  => $cachedir,
    configfile                => $configfile,
    sources                   => $sources,
    purgedirs                 => $purgedirs,
    modulepath                => $modulepath,
    remote                    => $remote,
    manage_modulepath         => $manage_modulepath,
    r10k_basedir              => $r10k_basedir,
    manage_configfile_symlink => $manage_configfile_symlink,
    configfile_symlink        => $configfile_symlink,
    git_provider              => $git_provider,
    git_private_key           => $git_private_key,
    git_username              => $git_username,
  }

  if $mcollective {
    class { 'r10k::mcollective': }
  }
}
