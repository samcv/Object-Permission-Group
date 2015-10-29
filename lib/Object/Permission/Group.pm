use v6;

use Object::Permission;

class Object::Permission::Group does Object::Permission::User {
    use Unix::Groups;

    has Unix::Groups $!groups;
    has Str $.user;

    submethod BUILD(Str() :$!user!) {
        $!groups = Unix::Groups.new;

        for $!groups.groups-for-user($!user) -> $group {
            self.permissions.push($group.Str);
        }
    }

}

$*AUTH-USER = Object::Permission::Group.new(user => $*USER.Str);

# vim: expandtab shiftwidth=4 ft=perl6
