var app = angular.module("admin", ["ngMaterial", "services"]);

app.controller("adminCtl", function($scope, getGroupInfo, updateGroupInfo, getAllGroupUsers, loginService, registrationService) {
  loginService.getUserLogin().then(function(res) {
    // Determine if user is logged in; if so, get group information from refresh()
    if (res.userInfo) {
      $scope.isLoggedIn = true;
      var userInfo = res.userInfo;
      $scope.currentUserName = userInfo.given_name;
      $scope.currentUserID = userInfo.email.substring(0, res.userInfo.email.indexOf("@"));
      $scope.role = userInfo.role;
      refresh();
    } else {
      $scope.isLoggedIn = false;
      $scope.currentUserName = null;
      $scope.currentUserID = null;
      $scope.role = null;
    }
  });
  function refresh() {
    // re-fetch all data that might have been altered by user action
    if ($scope.isLoggedIn) {
      // do something
    }
  };

});
