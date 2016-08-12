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
        
        var MaxInputs       = 10; //Número Maximo de Campos
        var FieldCount      =  1; //para el seguimiento de los campos
            
        $("#btnAgregarTelefono").click(function(e){
            e.preventDefault();
            
            
            //agregar campo
            $("#listTelefonos").append('<div class="col-sm-8"><input type="text" class="form-control" name="telefonos[]" id="campo_'+ FieldCount +'"  placeholder="Telefono '+ FieldCount +'" maxlength="15" /><a href="#" class="eliminar glyphicon">&times;</a></div>');
            FieldCount++; //text box increment
            return false;
        });
        
        $("body").on("click",".eliminar", function(e){ //click en eliminar campo
            $(this).parent('div').remove(); //eliminar el campo
            return false;
        });
        
        $('#myModal').on('hidden.bs.modal', function (e) {
            ContactosNuevo.resetearCampos();
        });
        
        $("body").on("click",".editar", function(e){ //click en el link editar un telefono
            var id = 0;
            id = $(this).attr('idrel');
            
            var urlList = baseUrl + '/' + 'contactos/get';
            $.ajax({
                type: "POST",
                url: urlList,
                data:  {id:id},
                dataType: "json",
                success: function(response){
                    console.log(response);
                    if(response.result = 'success'){
                        $("#idContacto").val(response.id);
                        $("#nombre").val(response.nombres);
                        $("#apellidos").val(response.apellidos);
                        $("#direccion").val(response.direccion);
                        $("#email").val(response.email);
                        
                        $.each(response.telefonos, function(i, item) {
                            console.log('i', item.numero);
                            $("#listTelefonos").append('<div class="col-sm-8"><input type="text" class="form-control" name="telefonos[]" id="campo_'+ item.id +'"  placeholder="Telefono '+ item.id +'" value="'+ item.numero +'" maxlength="15" /><a href="#" class="eliminar glyphicon">&times;</a></div>');
                        });
                        
                        $('#myModal').modal('show');
                    } else {
                        alert('El contacto no existe.');
                    }
                }
            });
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
                    //ContactosNuevo.resetearCampos();
                    $('#myModal').modal('hide');
                } else {
                    alert("Error al guardar " + response.msg);
                    return false;
                }
            }
        });
    },
    resetearCampos : function() {
        $("#idContacto").val("0");
        $("#nombre").val("");
        $("#apellidos").val("");
        $("#direccion").val("");
        $("#email").val("");
        $("#listTelefonos").html("");
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

