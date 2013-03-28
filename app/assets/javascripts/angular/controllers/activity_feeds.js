function ActivityFeedsController ($scope, $http) {
  $http.get('/achievements/newest/0.json').success(function (data) {
    $scope.achievements = data;
    $scope.orderProp = '-id';
    
    var max = 0, maxIndex = -1;
    for(var i=0;i<data.length;i++) {
       if(parseInt(data[i].id,10) > max) {
          max = data[i].id;
          maxIndex = i;
       }
    }

    var interval = setInterval(function () {
      $http.get('/achievements/newest/' + max + '.json').success(function (data) {
        $('.achievements')
      });
    }, 5000);

  });
}
