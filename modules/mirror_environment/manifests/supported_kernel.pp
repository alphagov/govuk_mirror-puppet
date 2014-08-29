# A class to install supported kernels based on a Hiera key

class mirror_environment::supported_kernel (
  $hwe_ver,
) {
    if ($hwe_ver){
      # Install HWE kernel. Version specified in Hiera.
        package {[
          "linux-generic-lts-${hwe_ver}",
          "linux-image-generic-lts-${hwe_ver}",
        ]:
          ensure => present,
        }
      }
  }
