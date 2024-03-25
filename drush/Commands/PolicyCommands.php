<?php

namespace Drush\Commands;

use Consolidation\AnnotatedCommand\CommandData;
use Drush\Drush;

/**
 * Edit this file to reflect your organization's needs.
 */
class PolicyCommands extends DrushCommands {

  /**
   * Parameter to set the instance is protected.
   */
  const PROTECTED_PARAMETER = "protected-instance";

  /**
   * Not execute the rsync if the instance is protected.
   *
   * @hook validate sql:sync
   *
   * @throws \Exception
   */
  public function sqlSyncValidate(CommandData $commandData) {
    $target_alias = $commandData->input()->getArgument('target');
    if ($this->isInstanceProtected($target_alias)) {
      throw new \Exception(dt('Alias: !alias. You can not overwrite the database.', ['!alias' => $target_alias]));
    }
  }

  /**
   * Not execute the rsync if the instance is protected.
   *
   * @hook validate core:rsync
   *
   * @throws \Exception
   */
  public function rsyncValidate(CommandData $commandData) {
    $target_alias = $commandData->input()->getArgument('target');
    if ($this->isInstanceProtected($target_alias)) {
      throw new \Exception(dt('Alias: !alias. You can not overwrite the code or the files.', ['!alias' => $target_alias]));
    }
  }

  /**
   * Not execute the sql:drop if the instance is protected.
   *
   * @hook validate sql:drop
   *
   * @throws \Exception
   */
  public function dropValidate(CommandData $commandData) {
    if ($this->isInstanceProtected('@self')) {
      throw new \Exception(dt('You are not allowed to delete the database.'));
    }
  }

  /**
   * Determine if an instance is protected.
   *
   * @param string $alias
   *   Alias of drush. Self if it is local.
   *
   * @return bool
   *   If it is protected.
   */
  protected function isInstanceProtected(string $alias): bool {
    // If alias is local, check the user context configuration.
    if ($alias === "@self") {
      $user_context = $this->getConfig()->getContext('user');
      return $user_context->get(PolicyCommands::PROTECTED_PARAMETER, NULL) ?? FALSE;
    }

    // Check the alias configuration.
    $alias_configuration = Drush::aliasManager()->getAlias($alias);
    if (empty($alias_configuration)) {
      return FALSE;
    }
    return $alias_configuration->get(PolicyCommands::PROTECTED_PARAMETER, NULL) ?? FALSE;
  }

}
