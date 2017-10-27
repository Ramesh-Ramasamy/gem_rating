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

  $rest.all('vendor_rating').customGETLIST('get_rating_factors').then(function(data){
    $scope.rating_factors = data[0].rating_factors_tree
    console.log(data)
  });

  $scope.updateFactor = function(rating_factor){
    console.log("Ramesh",rating_factor)
    ha = {}
    ha.id = rating_factor.id
    ha.config = rating_factor.attrs.config
    ha.weightage = rating_factor.attrs.weightage
        // rating_factor.cpnfig = rating_factor.attrs.config
    // rating_factor.cpnfig = rating_factor.
    // rating_factor.cpnfig = rating_factor.config 
    $rest.all('vendor_rating').customPOST({},'update_rating_factor',{id : ha.id,config: ha.config,weightage: ha.weightage }).then(function(data){
      if(data.status == "success")
        $scope.addAlert({type:data.status,msg: "Updated Successfully!!!"})
      else
        $scope.addAlert({type:'danger',msg: "Updation Not completed due to some error"})
    })
  }

  editableAttrs = ['weightage', 'config']
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

