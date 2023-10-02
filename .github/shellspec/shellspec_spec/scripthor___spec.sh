%const SCRIPTHOR_SCRIPTS: "backup.sh copy-content-config-entity-to-module.sh frontend-build.sh reload-local.sh setup-traefik-port.sh"

Describe 'Scripthor' scripthor

  Context 'script'
    Parameters:value $SCRIPTHOR_SCRIPTS

    It "'$1' is symlinked"
      The path "scripts/$1" should be symlink
      The path "scripts/$1" should be readable
    End
  End
End
