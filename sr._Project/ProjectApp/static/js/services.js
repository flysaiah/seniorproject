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
        var data = {"hasGroup": true, "groupID": 0};
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
        var data = {"wasSuccessful": false, "reason": "time"};  // reason can be: 'time', 'taken', 'size'
        return data;
      });
      return promise;
    }, getRegistrationTime: function(groupID) {
      var body = {
        "groupID": groupID,
      }
      var promise = $http.post('/getRegistrationTime', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var data = {"registrationTime": "3/9/16 at 9:30pm"};
        return data;
      });
      return promise;
    }
  };
  return registrationService;
});

app.factory('loginService', function($http) {
  // Login services
  var loginService = {
    getUserLogin: function() {
      var promise = $http.get('/getUserLogin').then(function (response) {
        if (response.data.userInfo.error) {
          return {};
        }
        return response.data;
      });
      return promise;
    }
  };
  return loginService;
});

app.factory('getRoomInfo', function($http) {
  // Get information regarding rooms
  var getRoomInfo = {
    getOccupantsDict: function(buildingName, roomArray) {
      // Return list of current occupants of each room
      var body = {
        "buildingName": buildingName,
        "roomArray": roomArray
      }
      var promise = $http.post('/getRoomOccupantsDict', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var testData = {
          "101":         [
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
          ],
          "102": [],
          "103": []
        }

        return {"occupantsDict": testData};
      });
      return promise;
    }
  };
  return getRoomInfo;
});
app.factory('adminService', function($http) {
  // Perform functions admins in Res Life can request
  var adminService = {
    switchRoomAvailability: function(buildingName, roomNumber) {
      // manually changes room availability, turns room "on" or "off"
      var body = {
        "buildingName": buildingName,
        "roomNumber": roomNumber
      }
      var promise = $http.post('/switchRoomAvailability', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var testData = {
          "wasSuccessful": false
        }

        return {"wasSuccessful": testData};
      });
      return promise;
    }
  };
  return adminService;
});
