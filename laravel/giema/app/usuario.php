<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class usuario extends Model
{
    //
    protected $fillable = ['username'];
      protected $fillable = ['clave'];
        protected $fillable = ['nombres'];
          protected $fillable = ['apellidos'];
            protected $fillable = ['correo'];
              protected $fillable = ['tipo_usuario'];

}
