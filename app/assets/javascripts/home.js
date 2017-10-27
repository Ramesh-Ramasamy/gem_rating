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

  $scope.alerts = []

  $scope.addAlert = function(alert) {
    $scope.alerts.push(alert)
  };

  $scope.closeAlert = function(index) {
    $scope.alerts.splice(index, 1)
  };

  $rest.all('vendor_rating').customGET('get_rating_factors').then(function(data){
    $scope.rating_factors = data.rating_factors_tree
    console.log(data)
  });

  $scope.updateFactor = function(rating_factor){
    console.log("Ramesh",rating_factor)
    $rest.all('vendor_rating').customPOST({},'update_rating_factor',{id : rating_factor.id,config: rating_factor.config,weightage: rating_factor.weightage }).then(function(data){
      if(data.status == "success")
        $scope.addAlert({type:data.status,msg: "Updated Successfully!!!"})
      else
        $scope.addAlert({type:'danger',msg: "Updation Not completed due to some error"})
    })
  }
  notShowingAttrs = ['id','config','children','code']
  $scope.isNotShowing = function(key,value){
    if(angular.equals({}, value))
      return true 
    return  _.indexOf(notShowingAttrs, key) == -1 ? false : true
  } 
  editableAttrs = ['name','weightage', 'config']
  $scope.isNotEditable = function(key){
    return  _.indexOf(editableAttrs, key) == -1 ? true : false
  }
  percentageAttrs = ['weightage']
  $scope.isPercentageAttrs = function(key){
    return  _.indexOf(percentageAttrs, key) == -1 ? false : true
  }
  $scope.arrow_img = function(arrowimg){
    return (arrowimg == 'down') ? 'up' : 'down'
  }
}])

