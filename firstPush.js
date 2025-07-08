//Importing mongoose for database modeling 
//and bcrypt for hashing 
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

//Schema structure with unique features
const userSchema = new mongoose.Schema({
    username: String,
    email: {type: String, unique: true},
    password: String,
    roleID: { type: String, enum: ['roleName'], default: 'user'}
});

//Presaves hook before saving a user to database
userSchema.pre('save', async function() {
    if (this.isModified('password')) {
        this.password = await bcrypt.hash(this.password, 10)
    }
    next();
});

//compare given password with hash password
userSchema.methods.comparePassword = function(password) {
    return bcrypt.compare(password, this.password);
};