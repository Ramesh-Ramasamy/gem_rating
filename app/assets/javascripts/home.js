home = angular.module("home",["ui.router"])//, ["restangular","ui.bootstrap","ui.router"])
//,"oc.lazyLoad"
home.config(['$stateProvider','$urlRouterProvider',function($stateProvider,$urlRouterProvider) {
  // $urlRouterProvider.otherwise("/home")
  $urlRouterProvider.otherwise('/');
  $stateProvider.state('/',{
    url: "/",
    views: {
      "homeview@" : {
        templateUrl: '/assets/vendor_rating/index.html'
      }
    }
  })
}])

home.controller("vendorRatingCtrl", ["$scope", function($scope){
  $scope.h = "John";
}])

