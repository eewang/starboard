function GridListController($scope) {
  $scope.grid = 320;
  $scope.gridEls = $('.group-grid .user');

  $scope.zoomIn = function ($event) {
    if ($scope.grid < 440) {
      $scope.grid = $scope.grid * 1.2
      console.log($scope.grid);
      $('.group-grid .user, .group-grid a').animate({ 'height' : String($scope.grid) + 'px',
                      'width'  : String($scope.grid) + 'px' }, 100, 'swing');
    }
  }
  
  $scope.zoomOut = function ($event) {
    if ($scope.grid > 137) {
      $scope.grid = $scope.grid * 0.8
      $('.group-grid .user, .group-grid a').animate({ 'height' : String($scope.grid) + 'px',
                      'width'  : String($scope.grid) + 'px' }, 100, 'swing');
    };
  }
}