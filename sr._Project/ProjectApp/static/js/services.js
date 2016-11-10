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
    }, leaveGroup: function(userID) {
      // Removes user from group
      var body = {
        "userID": userID
      }
      var promise = $http.post('/leaveGroup', body).error(function(response) {
        console.log(response);
      });
      return promise;
    }, createGroup: function(userID) {
      // Creates group with user as single member
      var body = {
        "userID": userID
      }
      var promise = $http.post('/createGroup', body).error(function(response) {
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

app.factory('getAllGroupUsers', function($http) {
  // Return list of all active users who are in groups
  var getAllGroupUsers = {
    fetchData: function() {
      var promise = $http.get('/getAllGroupUsers').then(function (response) {
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

        return {"allGroupUsers": testData};
      });
      return promise;
    }
  };
  return getAllGroupUsers;
});

app.factory('registrationService', function($http) {
  // Perform services dealing with registration
  var registrationService = {
    registerForRoom: function(groupID, buildingName, roomNumber) {
      // Assign room to group; return bool regarding whether registration was successful
      var body = {
        "groupID": groupID,
        "buildingName": buildingName,
        "roomNumber": roomNumber
      }
      var promise = $http.post('/registerForRoom', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var data = {"wasSuccessful": true};
        return data;
      });
      return promise;
    }
  };
  return registrationService;
});

app.factory('getRoomInfo', function($http) {
  // Get information regarding rooms
  var getRoomInfo = {
    getOccupants: function(buildingName, roomNumber) {
      // Return list of current occupants of room
      var body = {
        "buildingName": buildingName,
        "roomNumber": roomNumber
      }
      var promise = $http.post('/getRoomOccupants', body).then(function (response) {
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

        return {"roomOccupants": testData};
      });
      return promise;
    }
  };
  return getRoomInfo;
});
