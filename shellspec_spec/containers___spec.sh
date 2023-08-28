

%const CONTAINER_NAMES: "php traefik node hub chrome backstopjs mkdocs mariadb nginx adminer mailhog"
%const CONTAINER_COUNT: 11

Describe 'Container infrastructure:'

  Context 'container'
    Parameters:value $CONTAINER_NAMES

    It "'$1' container is running"
      When call container_is_alive $1
      The status should be success
    End
  End

    Context 'running container count'

    It "must be $CONTAINER_COUNT"
      When call container_count
      The output should equal $CONTAINER_COUNT
    End
  End
End

