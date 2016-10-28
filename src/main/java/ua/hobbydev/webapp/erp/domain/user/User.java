/**
 * This software is licensed under the terms of the MIT license.
 * Copyright (C) 2016 Dmytro Romenskyi
 */
package ua.hobbydev.webapp.erp.domain.user;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import ua.hobbydev.webapp.erp.domain.IdentifiedEntityInterface;
import ua.hobbydev.webapp.erp.domain.reports.TimeReport;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "users")
public class User implements IdentifiedEntityInterface, UserDetails {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "userInfoId")
    private UserInformation userInformation;
    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "loginInfoId")
    private UserLoginInformation userLoginInformation;
    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "authInfoId")
    private UserAuthorityInformation userAuthorityInformation;
    @OneToMany(mappedBy = "reporter", cascade = CascadeType.ALL)
    private List<TimeReport> timeReports;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public String getUsername() {
        return getUserLoginInformation().getUsername();
    }

    @Override
    public String getPassword() {
        return getUserLoginInformation().getPassword();
    }

    @Override
    public List<SimpleGrantedAuthority> getAuthorities() {
        return getUserAuthorityInformation().getAuthorities();
    }

    public UserInformation getUserInformation() {
        return userInformation;
    }

    public void setUserInformation(UserInformation userInformation) {
        this.userInformation = userInformation;
        userInformation.setUser(this);
    }

    public UserLoginInformation getUserLoginInformation() {
        return userLoginInformation;
    }

    public void setUserLoginInformation(UserLoginInformation userLoginInformation) {
        this.userLoginInformation = userLoginInformation;
        userLoginInformation.setUser(this);
    }

    public UserAuthorityInformation getUserAuthorityInformation() {
        return userAuthorityInformation;
    }

    public void setUserAuthorityInformation(UserAuthorityInformation userAuthorityInformation) {
        this.userAuthorityInformation = userAuthorityInformation;
        userAuthorityInformation.setUser(this);
    }

    public List<TimeReport> getTimeReports() {
        return timeReports;
    }

    public void setTimeReports(List<TimeReport> timeReports) {
        this.timeReports = timeReports;
    }

    public void addTimeReport(TimeReport timeReport) {
        timeReports.add(timeReport);
        timeReport.setReporter(this);
    }

    // ~ ====== UserDetails methods implementation


    @Override
    @Transient
    public boolean isAccountNonExpired() {
        return isEnabled();
    }

    @Override
    @Transient
    public boolean isAccountNonLocked() {
        return isEnabled();
    }

    @Override
    @Transient
    public boolean isCredentialsNonExpired() {
        return isEnabled();
    }

    @Override
    @Transient
    public boolean isEnabled() {
        return true;
    }

    // ~ ======== Hashcode and equals

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User that = (User) o;

        return getId().equals(that.getId());

    }

    @Override
    public int hashCode() {
        return getId().hashCode();
    }
}
