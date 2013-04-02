function ActivityFeedsController ($scope, $http) {
  var groupId = $(document.URL.split('/')).last()[0];
  $http.get('/achievements/newest.json?groupid=' + groupId +'&latestachievement=0').success(function (data) {
    $scope.achievements = data;
    $scope.orderProp = '-id';

    var max = 0, maxIndex = -1;

    function updateMax (data) {
      for(var i=0;i<data.length;i++) {
       if(parseInt(data[i].id,10) > max) {
          max = data[i].id;
          maxIndex = i;
        }
      }
    }

    updateMax($scope.achievements);

    function recursivePoll () {
      setTimeout(function () {
        $http.get('/achievements/newest.json?groupid=' + groupId +'&latestachievement=' + max).success(function (data) {
          // Prepend the scope achievements with the new data,
          // make sure the result is only 20 items long
          $scope.achievements = data.concat($scope.achievements).splice(0, 19);
          updateMax($scope.achievements);
          $scope.$$phase || $scope.$apply();
        }).success(recursivePoll);
      }, 5000);
    }
  });
}
