# == Class: mirror_environment::user
#
# Create mirror-rsync user account with group,
# copies the ssh_key to authorized_keys
#
# === parameters
#
# [*username*]
#  Unix account user name
#
# [*ssh_key*]
#  Public part of ssh key
#
class mirror_environment::user (
  $username,
  $ssh_key
) {
  account { $username:
    ssh_key => $ssh_key,
    comment => 'Mirror user which rsynchs data',
  }
}
