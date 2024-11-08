import homeTest from './home.test'
import localUnitTest from './LocalUnit.test';

export default function testsuite() {
  localUnitTest();
  homeTest()
}