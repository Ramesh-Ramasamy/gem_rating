home = angular.module("home",['restangular','ui.router','ui.bootstrap','ngAnimate'])
home.config(['$stateProvider','$urlRouterProvider',function($stateProvider,$urlRouterProvider) {
  $urlRouterProvider.otherwise('/')
  $stateProvider.state('/',{
    url: "/",
    views: {
      "homeview@" : {
        templateUrl: '/assets/vendor_rating/index.html'
      }
    }
  })
}])

home.controller("vendorRatingCtrl", ['$scope','Restangular', function($scope,$rest){

  $rest.all('vendor_rating').customGETLIST('get_rating_factors').then(function(data){
    $scope.rating_factors = data
  });

  $scope.updateFactor = function(rating_factor){
    console.log("Ramesh",rating_factor)
  }

  editableAttrs = ['weightage', 'config']
  $scope.isNotEditable = function(key){
    return  _.indexOf(editableAttrs, key) == -1 ? true : false
  }

  $scope.arrow_img = function(arrowimg){
    return (arrowimg == 'down') ? 'up' : 'down'
  }
}])

