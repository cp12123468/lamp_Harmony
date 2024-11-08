import homeTest from './home.test'
import loginPageTest from './loginPage.test'
import abilityTest from './Ability.test';

export default function testsuite() {
  abilityTest();
  loginPageTest()
  homeTest()
}