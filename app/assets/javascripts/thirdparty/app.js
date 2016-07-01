 // Angular App
 angular.module('app', ['ngMaterial'])
    .controller('sideNavController', sideNavController);

    function sideNavController ($scope, $mdSidenav, $window) {
	
		$scope.openLeftMenu = function() {
           $mdSidenav('left').toggle();
           $mdSidenav('right').close();
         };


   		$scope.openRightMenu = function() {
           $mdSidenav('right').toggle();
           $mdSidenav('left').close();
         };

     //    $scope.showtab = function (){
     //      	navwidth = (window.innerWidth);
     //      	if (navwidth < 768) {
  			//     return true;
  			// } else {
  			//     return false;
  			// }
     //      };
  }
