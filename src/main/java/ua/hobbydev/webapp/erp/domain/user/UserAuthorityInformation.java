/**
 * This software is licensed under the terms of the MIT license.
 * Copyright (C) 2016 Dmytro Romenskyi
 */
package ua.hobbydev.webapp.erp.domain.user;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import ua.hobbydev.webapp.erp.domain.IdentifiedEntityInterface;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "usersAuthorities")
public class UserAuthorityInformation implements IdentifiedEntityInterface {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    private User user;

    @OneToMany(cascade = CascadeType.ALL)
    private List<Role> roles;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    @Transient
    public List<SimpleGrantedAuthority> getAuthorities() {
        Set<SimpleGrantedAuthority> authorities = new HashSet<SimpleGrantedAuthority>();

        for(Role r:getRoles()) {
            String authoritiesString = r.getAuthorities();
            for(GrantedAuthority a:AuthorityUtils.commaSeparatedStringToAuthorityList(authoritiesString)) {
                SimpleGrantedAuthority sga = new SimpleGrantedAuthority(a.getAuthority());
                authorities.add(sga);
            }
        }

        List<SimpleGrantedAuthority> list = new ArrayList<SimpleGrantedAuthority>();
        list.addAll(authorities);

        return list;
    }

    // ~ ======== Hashcode and equals

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserAuthorityInformation that = (UserAuthorityInformation) o;

        return getId().equals(that.getId());

    }

    @Override
    public int hashCode() {
        return getId().hashCode();
    }
}
