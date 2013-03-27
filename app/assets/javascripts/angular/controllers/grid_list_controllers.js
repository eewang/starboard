function GridListController($scope, $http) {
  $http.get('/users.json').success(function (data) {
    $scope.users = data;
    $scope.orderProp = '-achievements';
    $scope.grid = 320;
    $scope.gridEls = $('.group-grid .user');

    $scope.zoomIn = function ($event) {
      if ($scope.grid < 440) {
        $scope.grid = $scope.grid * 1.1
        console.log($scope.grid);
        $('.group-grid .user').animate({ 'height' : String($scope.grid) + 'px',
                        'width'  : String($scope.grid) + 'px' }, 100, 'swing');
      }
    }
    
    $scope.zoomOut = function ($event) {
      if ($scope.grid > 137) {
        $scope.grid = $scope.grid * 0.9
        $('.group-grid .user').animate({ 'height' : String($scope.grid) + 'px',
                        'width'  : String($scope.grid) + 'px' }, 100, 'swing');
      };
    }
  })
}
