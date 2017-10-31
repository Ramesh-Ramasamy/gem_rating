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

home.directive("disableOnclick", ["$timeout", function($timeout) {
    return {
      restrict: "A",
      link: function(scope, element, attrs) {
        return element.bind('click', function() {
          element.attr("disabled", true);
          scope.$apply(attrs.disableOnclick);
          return $timeout(function() {
            return element.attr("disabled", false);
          }, 5000)
        })
      }
    }
  }
])

home.directive('updateFactorNW', function(){

  return {
      restrict: 'E',
      replace: 'true',
      scope: {
        factor: '='
      },
      template: '<a href="#" ng-click="modalOpen()">Update Weightage</a>',
      controller:['$scope','$uibModal', function($scope,$uibModal){
        // $scope.$watch('factor', function (newValue) {
        //   this.factor = newValue;
        //   console.log("factor",$scope.factor)
        // }.bind(this));
        $scope.modalOpen = function (size, parentSelector) {
          var modalInstance = $uibModal.open({
            animation: true,
            ariaLabelledBy: 'modal-title',
            ariaDescribedBy: 'modal-body',
            templateUrl: '/assets/vendor_rating/directive_update.html',
            controller: 'ModalInstanceCtrl',
            controllerAs: '$ctrl',
            size: size,
            resolve: {
              factors: function () {
                return $scope.factor;
              }
            }
          }).result.then(function(res) {
            
          },function(){

          })
        }
      }]
  };

})

home.controller('ModalInstanceCtrl',['$uibModalInstance','Restangular','factors', function ($uibModalInstance,$rest,factors) {
  var $ctrl = this
  $ctrl.alerts = []

  $ctrl.addAlert = function(alert) {
    $ctrl.alerts.push(alert)
  };

  $ctrl.closeAlert = function(index) {
    $ctrl.alerts.splice(index, 1)
  };

  $ctrl.factors = factors
  console.log("ModalInstanceCtrl",$ctrl.factors)
  // $ctrl.selected = {
  //   item: $ctrl.items[0]
  // };

  // $ctrl.ok = function () {
  //   $uibModalInstance.close($ctrl.selected.item);
  // };
  $ctrl.weitageSum = _.sumBy(factors, 'weightage')

  $ctrl.totalWeightage = function(factor){
    factor.weightage = _.toNumber(factor.weightage)
    $ctrl.weitageSum = _.sumBy($ctrl.factors, 'weightage')
    // return $ctrl.weitageSum
  }
  $ctrl.updateWeightage= function(){
    console.log("called", $ctrl.factors)
    factors = $ctrl.factors
    $rest.all('vendor_rating').customPOST({factors: factors},'update_rating_factors',{}).then(function(data){
      console.log("uw",data)
       if(data.status == "success")
        $ctrl.addAlert({type:data.status,msg: "Updated Successfully!!!"})
      else
        $ctrl.addAlert({type:'danger',msg: "Updation Not completed due to some error"})
    })
  }

  $ctrl.cancel = function () {
    $uibModalInstance.dismiss('cancel')
  }
}])

home.controller("vendorRatingCtrl", ['$scope','Restangular','$uibModal', function($scope,$rest,$uibModal){
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

  $scope.selectAttrValues=['less_than','greater_than','equal_to','less_than_by','greater_than_by']

  $scope.capitalizeWord = function(str){
    return _.startCase(str);
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


  // $scope.modalOpen = function (size, parentSelector) {
  //   // var parentElem = parentSelector ? 
  //   //   angular.element($document[0].querySelector('.modal-demo ' + parentSelector)) : undefined;
  //   var modalInstance = $uibModal.open({
  //     animation: true,
  //     // ariaLabelledBy: 'modal-title',
  //     // ariaDescribedBy: 'modal-body',
  //     templateUrl: '/assets/vendor_rating/directive_update.html',
  //     // controller: 'ModalInstanceCtrl',
  //     // size: size,
  //     // appendTo: parentElem,
  //     // resolve: {
  //     //   items: function () {
  //     //     return $scope.items;
  //     //   }
  //     // }
  //   })
  // }
}])


