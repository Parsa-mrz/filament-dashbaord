<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Team extends Model
{
    protected $fillable = ['name','slug'];
    public function employees(): HasMany
    {
        return $this->hasMany(Employee::class);
    }

    public function members()
    {
        return $this->belongsToMany(User::class);
    }
}
