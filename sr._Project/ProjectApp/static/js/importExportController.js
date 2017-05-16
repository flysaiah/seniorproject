var app = angular.module("importexport", ["ngMaterial", "services"]);

app.controller("importExportCtl", function($scope, loginService) {

  loginService.getUserLogin().then(function(res) {
    // Determine if user is logged in; if so, get group information from refresh()
    if (res.userInfo) {
      $scope.isLoggedIn = true;
      $scope.role = res.role;
    } else {
      $scope.isLoggedIn = false;
      $scope.role = null;
    }
  });
});
