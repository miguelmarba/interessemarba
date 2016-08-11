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
        
    },// End Init()
    
    validarCampos : function() {
        var validator = $( "#frmNuevoContacto" ).validate();
        //validator.form();
        if(validator.form()){
            ContactosNuevo.guardarContacto();
        }
    },
    
    guardarContacto : function() {
        //alert("Hola Miguel Angel ----- guardarContacto"); return false;
        var urlSave = baseUrl + '/' + 'contactos/add';
        $.ajax({
            type: "POST",
            url: urlSave,
            data:  $("#frmNuevoContacto").serialize(),
            dataType: "json",
            success: function(response){
                console.log(response);
                if( response.success == true){
                    alert("Datos guardados correctamente");
                } else {
                    alert("Error al guardar " + response.msg);
                    return false;
                }
                return true;
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

