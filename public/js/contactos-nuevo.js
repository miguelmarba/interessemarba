// Procedimientos para agregar un nuevo contacto.
// Examen Interesse
// ++++++++++++++++++++++++++++++++++++++++++
/*!
 * Copyright 2016-2017 Marba, Inc.
 *
 * Licensed under the Marba Technologies 1.0 Unported License. For
 * details, see https://marba.org/licenses/by/1.0/.
 */
var ContactosNuevo = {
    init : function() {
        $("#btnGuardarContacto").click(function(){
            ContactosNuevo.validarCampos();
        });
        
        //Cargamos los contactos
        ContactosNuevo.listarContactos();
    },// End Init()
    
    listarContactos : function() {
        var baseUrl = 'http://localhost/interessemarba/public';
        var urlList = baseUrl + '/' + 'contactos/list';
        $.ajax({
            type: "POST",
            url: urlList,
            data:  {i:1},
            dataType: "html",
            success: function(response){
                console.log(response);
                $(".panel-body").html(response);
            }
        });
    },
    validarCampos : function() {
        var validator = $( "#frmNuevoContacto" ).validate();
        //validator.form();
        if(validator.form()){
            ContactosNuevo.guardarContacto();
        }
    },
    
    guardarContacto : function() {
        var urlSave = baseUrl + '/' + 'contactos/add';
        $.ajax({
            type: "POST",
            url: urlSave,
            data:  $("#frmNuevoContacto").serialize(),
            dataType: "json",
            success: function(response){
                console.log(response);
                if( response.result == 'success'){
                    ContactosNuevo.listarContactos();
                    alert("Datos guardados correctamente");
                    $('#myModal').modal('hide');
                } else {
                    alert("Error al guardar " + response.msg);
                    return false;
                }
            }
        });
    },
    resetearCampos : function() {
        $("#nombre").val("");
        $("#apellidos").val("");
        $("#direccion").val("");
        $("#email").val("");
    }// End resetearCampos()
		
};
ContactosNuevo.init();



$().ready(function () {
    $("#frmNuevoContacto").validate({
        rules: {
            nombre:"required",
            email:{
                required: false,
                email:true
            }
        },
        messages: {
            nombre:"Por favor ingrese su nombre.",
            email:{
                email:"Por favor ingrese con correo electrónico válido."
            }
        },
        submitHandler: function(form) {
            //form.submit();
            alert("Hola Miguel Angel ----- guardarContact jajajajajajajo");
            ContactosNuevo.guardarContacto();
        }
    });
});


(function () {
  'use strict';

})();

