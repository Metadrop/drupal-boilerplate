<?php

/**
 * @file
 * Behat Feature Context file.
 */

use Behat\Behat\Tester\Exception\PendingException;
use Drupal\DrupalExtension\Context\DrupalContext;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behat\Behat\Hook\Scope\AfterStepScope;
use Behat\Testwork\Tester\Result\TestResult;
use Behat\Mink\Exception\ExpectationException;
use Drupal\DrupalExtension\Hook\Scope\BeforeNodeCreateScope;
use Drupal\user\Entity\Role;
use Drupal\user\RoleInterface;

class FeatureContext extends DrupalContext implements SnippetAcceptingContext {

  /**
   * @var Drupal\DrupalExtension\Context\MinkContext
   */
  protected $minkContext;

  /**
   * Responsive context.
   *
   * @var \NuvoleWeb\Drupal\DrupalExtension\Context\ResponsiveContext
   */
  protected $responsiveContext;

  /**
   * Permissions to grant and revoke on before and after suite.
   *
   * @code
   * $permissions = [
   *   "grant" => [
   *      "edit any article content" => [RoleInterface::ANONYMOUS_ID],
   *   ],
   *   "revoke" => [
   *     "access content" => [RoleInterface::ANONYMOUS_ID],
   *   ],
   * ];
   *
   * @var array
   */
  static protected $permissions = [];

  /**
   * Sets User permissions
   *
   * @BeforeSuite
   */
  public static function beforeSUserPermissionsSet() {
    $roles = Role::loadMultiple();
    foreach (self::$permissions as $type => $value) {
      foreach ($value as $permission => $rolesList) {
        foreach ($rolesList as $role) {
          $roles[$role]->{$type . 'Permission'}($permission);
          $roles[$role]->trustData()->save();
        }
      }
    }
  }

  /**
   * Restores User permissions
   *
   * @AfterSuite
   */
  public static function afterUserPermissionsRestore() {
    $roles = Role::loadMultiple();
    foreach (self::$permissions as $type => $value) {
      foreach ($value as $permission => $rolesList) {
        foreach ($rolesList as $role) {
          $utype = $type == 'grant' ? 'revoke' : 'grant';
          $roles[$role]->{$utype . 'Permission'}($permission);
          $roles[$role]->trustData()->save();
        }
      }
    }
  }

  /**
   * Recolecta los subcontexteos necesarios.
   *
   * @BeforeScenario
   *
   * @param BeforeScenarioScope $scope
   *   Scope del scenario.
   */
  public function gatherContexts(BeforeScenarioScope $scope) {
    $environment = $scope->getEnvironment();
    $this->minkContext = $environment->getContext('Drupal\DrupalExtension\Context\MinkContext');
    $this->responsiveContext = $environment->getContext('NuvoleWeb\Drupal\DrupalExtension\Context\ResponsiveContext');
  }

  /**
   * Constructor.
   *
   * Guarda las parámetros custom, si los hay.
   *
   * @param type $parameters
   */
  public function __construct($parameters = NULL) {
    $this->customParameters = !empty($parameters) ? $parameters : array();
  }

  /**
   * Sets EU Cookie Compliance: Accept.
   *
   * @BeforeScenario @cookies-accept
   */
  public function beforeSetCookiesAccept() {
    // The cookie is always sent for the current domain. Since you didn't visit
    // a page yet, the domain has not been set yet. At the moment there's no way
    // to choose a domain for a cookie with mink.
    // You need to make a request before sending a cookie.
    $this->visitPath('/');
    $this->getSession()->setCookie("cookie-agreed", "2");
  }

  /**
   * Sets EU Cookie Compliance: Reject.
   *
   * @BeforeScenario @cookies-reject
   */
  public function beforeSetCookiesReject() {
    $this->visitPath('/');
    $this->getSession()->setCookie("cookie-agreed", "0");
  }

  /**
   * Clear cache.
   *
   * @BeforeScenario @cache-clear
   */
  public function cacheClearTag() {
    $this->assertCacheClear();
  }

  /**
   * Before scenario sets the viewport to desktop on javascript tests.
   *
   * @BeforeScenario @javascript
   */
  public function beforeSetViewportEditor() {
    $this->responsiveContext->assertDeviceScreenResize('desktop');
  }

}
