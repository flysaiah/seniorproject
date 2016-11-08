var app = angular.module("services",[]);
app.factory('getGroupInfo', function($http) {
  // Get info about group members and group requests
  var getGroupInfo = {
    fetchGroupMembers: function(userID) {
      // Return group members of the group this user belongs to
      var body = {
        "userID": userID
      }
      var promise = $http.post('/getGroupMembers', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var testGroupMembers = [
          {
            "FirstName": "Isaiah",
            "LastName": "Mayerchak",
            "userID": "mayeis01"
          },
          {
            "FirstName": "Testy",
            "LastName": "Tester",
            "userID": "testuser01"
          }
        ];

        var testRequestingMembers = [
          {
            "FirstName": "Zeke",
            "LastName": "Smith",
            "userID": "smitze01"
          },
          {
            "FirstName": "Ihab",
            "LastName": "Saud",
            "userID": "saudih01"
          }
        ];
        var data = {"groupMembers": testGroupMembers, "requestingMembers": testRequestingMembers}
        return data;
      });
      return promise;
    }, isUserInGroup: function(userID) {
      // Returns a boolean: true if user is in a group, false otherwise
      var body = {
        "userID": userID
      }
      var promise = $http.post('/isUserInGroup', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var data = {"hasGroup": true};
        return data;
      });
      return promise;
    }
  };
  return getGroupInfo;
});

app.factory('updateGroupInfo', function($http) {
  // Updates group metadata
  var updateGroupInfo = {
    acceptRequest: function(userID) {
      // Accept group membership request of member
      var body = {
        "userID": userID
      }
      var promise = $http.post('/acceptGroupRequest', body).error(function(response) {
        console.log(response);
      });
      return promise;
    }, rejectRequest: function(userID) {
      // Reject group membership request of member; remove user from pending
      var body = {
        "userID": userID
      }
      var promise = $http.post('/rejectGroupRequest', body).error(function(response) {
        console.log(response);
      });
      return promise;
    }, sendGroupRequest: function(sendingUserID, receivingUserID) {
      // Add user to "pending" of the group associated with this userID
      var body = {
        "sendingUserID": sendingUserID,   // ID of the person sending the request
        "receivingUserID": receivingUserID  // ID of the person whose group is receiving the request
      }
      var promise = $http.post('/sendGroupRequest', body).error(function(response) {
        console.log(response);
      });
      return promise;
    }
  };
  return updateGroupInfo;
});

app.factory('getFloorInfo', function($http) {
  // Gets information about how many floors there are in each building, as well as if ther eis a basement or not
  var getFloorInfo = {
    fetchData: function(bName) {
      // Using building name, get floor info
      var body = {
        "buildingName": bName
      }
      var promise = $http.post('/getFloorInfo', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var testData = {"floorList": ["B", "1", "2", "3", "4", "5", "6", "7"]};

        return testData;
      });
      return promise;
    }
  };
  return getFloorInfo;
});

app.factory('getAllUsers', function($http) {
  // Return list of all active user objects
  var getAllUsers = {
    fetchData: function() {
      var promise = $http.get('/getAllUsers').then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var testData = [
          {
            "firstName": "Isaiah",
            "lastName": "Mayerchak",
            "userID": "mayeis01"
          },
          {
            "firstName": "Testy",
            "lastName": "Tester",
            "userID": "testuser01"
          }
        ];

        return {"allUsers": testData};
      });
      return promise;
    }
  };
  return getAllUsers;
});
