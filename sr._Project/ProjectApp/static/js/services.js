var app = angular.module("services",[]);
app.factory('getGroupInfo', function($http) {
  // Get info about group members and group requests
  var getGroupInfo = {
    fetchGroupMembers: function(userID) {
      // Return group members of the group this user belongs to
      var body = {
        "userID": userID
      }
      var promise = $http.get('/getGroupMembers', body).then(function (response) {
        return response.data;
      }, function (err) {
        // for testing
        var testGroupMembers = [
          {
            "FirstName": "Isaiah",
            "LastName": "Mayerchak",
            "ID": "mayeis01"
          },
          {
            "FirstName": "Testy",
            "LastName": "Tester",
            "ID": "testuser01"
          }
        ];

        var testRequestingMembers = [
          {
            "FirstName": "Zeke",
            "LastName": "Smith",
            "ID": "smitze01"
          },
          {
            "FirstName": "Ihab",
            "LastName": "Saud",
            "ID": "saudih01"
          }
        ];
        data = {"groupMembers": testGroupMembers, "requestingMembers": testRequestingMembers}
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
    acceptRequest: function(userID, groupID) {
      // Accept group membership request of member
      var body = {
        "userID": userID,
        "groupID": groupID
      }
      var promise = $http.post('/acceptGroupRequest', body).error(function(response) {
        console.log(response);
      });
      return promise;
    }, rejectRequest: function(userID, groupID) {
          // Reject group membership request of member; remove user from pending
          var body = {
            "userID": userID,
            "groupID": groupID
          }
          var promise = $http.post('/rejectGroupRequest', body).error(function(response) {
            console.log(response);
          });
          return promise;
        }
  };
  return getGroupInfo;
});

app.factory('getFloorInfo', function($http) {
  // Gets information about how many floors there are in each building, as well as if ther eis a basement or not
  var getFloorInfo = {
    fetchData: function(bName) {
      // Using building name, get floor info
      var body = {
        "buildingName": bName
      }
      var promise = $http.get('/getFloorInfo', body).then(function (response) {
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
