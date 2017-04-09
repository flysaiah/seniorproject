var app = angular.module("services",[]);
// NOTE: Dummy data returned during errors for testing needs to be gone by production time
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
    }, getAutoRegPref: function(groupID) {
      // Get auto registration preferences for a given group
      var body = {
        "groupID": groupID
      }
      var promise = $http.post('/getAutoRegPref', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var data = {"autoRegEnabled": true, "autoRegPref": [{"buildingName": "Miller", "roomNumber": 103, "defaultPref": false},{"buildingName": "Dieseth", "roomNumber": 2, "defaultPref": true}]};
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
      var promise = $http.post('/acceptGroupRequest', body).then(function(response) {
        return response.data;
      }, function (err) {
        console.log(err);
      });
      return promise;
    }, rejectRequest: function(userID) {
      // Reject group membership request of member; remove user from pending
      var body = {
        "userID": userID
      }
      var promise = $http.post('/rejectGroupRequest', body).then(function(response) {
        return response.data;
      }, function (err) {
        console.log(err);
      });
      return promise;
    }, sendGroupRequest: function(sendingUserID, receivingUserID) {
      // Add user to "pending" of the group associated with this userID
      var body = {
        "sendingUserID": sendingUserID,   // ID of the person sending the request
        "receivingUserID": receivingUserID  // ID of the person whose group is receiving the request
      }
      var promise = $http.post('/sendGroupRequest', body).then(function(response) {
        return response.data;
      }, function (err) {
        console.log(err);
      });
      return promise;
    }, leaveGroup: function(userID) {
      // Removes user from group
      var body = {
        "userID": userID
      }
      var promise = $http.post('/leaveGroup', body).then(function(response) {
        return response.data;
      }, function (err) {
        console.log(err);
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
    }, saveAutoRegPref: function(groupID, autoRegEnabled, autoRegPref) {
      // Saves group preferences for auto registration
      var body = {
        "groupID": groupID,
        "autoRegEnabled": autoRegEnabled,  // boolean value
        "autoRegPref": autoRegPref        // example: [ {"buildingName": "Miller", "roomNumber": 103, "defaultPref": false}, {}, {}, {}, {} ]
      }
      var promise = $http.post('/saveAutoRegPref', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var data = {"wasSuccessful": false};
        return data;
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
          "101":
          {"isTaken": true, "roomOccupants": [
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
          ]},
          "102": {"isTaken": false, "roomOccupants": []},
          "103": {"isTaken": true, "roomOccupants": []}
        }

        return {"occupantsDict": testData};
      });
      return promise;
    }, getAllRoomNumbers: function() {
      // Return list of all building names + room numbers
      var promise = $http.get('/getAllRoomNumbers').then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var testData = {
          "Miller": [101, 102, 103, 104],
          "Dieseth": [101, 102, 103, 104]
        };

        return {"allRoomsDict": testData};
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
    }, manuallyAssignStudentsToRoom: function(buildingName, roomNumber, studentObjectList) {
      // manually assign students to room (duh)
      var userList = [];
      for (var i = 0; i < studentObjectList.length; i++) {
        userList.push(studentObjectList[i].searchID);
      }
      var body = {
        "buildingName": buildingName,
        "roomNumber": roomNumber,
        "userList": userList
      }
      var promise = $http.post('/manuallyAssignStudentsToRoom', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var testData = {
          "wasSuccessful": false,
        }

        return {"wasSuccessful": testData};
      });
      return promise;
    }, manuallyRemoveStudentsFromRoom: function(buildingName, roomNumber, studentObjectList) {
      // manually remove students from room (duh)
      var userList = [];
      for (var i = 0; i < studentObjectList.length; i++) {
        userList.push(studentObjectList[i].userID);
      }
      var body = {
        "buildingName": buildingName,
        "roomNumber": roomNumber,
        "userList": userList
      }
      var promise = $http.post('/manuallyRemoveStudentsFromRoom', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var testData = {
          "wasSuccessful": false,
        }

        return {"wasSuccessful": testData};
      });
      return promise;
    }, saveDeadlinePreferences: function(groupsDeadline, firstRegDate, startTime, endTime, timeInterval) {
      // update deadline for finding a group; when this deadline is hit, assign registration times
      // update first date for registration
      // update starting and ending times for registration each day
      // update time interval for registration batches
      var body = {
        "groupsDeadline": groupsDeadline,
        "firstRegistrationDate": firstRegDate,
        "startTime": startTime,
        "endTime": endTime,
        "timeInterval": timeInterval
      }
      var promise = $http.post('/saveDeadlinePreferences', body).then(function(response) {
        return response.data;
      }, function (err) {
        console.log(err);
      });

      return promise;
    }, fetchDeadlinesPreferences: function() {
      // get data to prepopulate fields in deadlines panel
      var promise = $http.get('/fetchDeadlinesPreferences').then(function(response) {
        return response.data;
      }, function (err) {
        // for testing
        var testData = {
          "groupsDeadline": new Date(2018, 2, 10),
          "firstRegistrationDate": new Date(2018, 3, 5),
          "startTime": new Date(2018, 3, 5, 18, 0, 0),
          "endTime": new Date(2018, 3, 5, 22, 30, 0),
          "timeInterval": 5;
        };

        return {"deadlinePrefs": testData};
      });
      return promise;
    }
  };
  return adminService;
});
