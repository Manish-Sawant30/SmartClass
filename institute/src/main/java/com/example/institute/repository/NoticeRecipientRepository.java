package com.example.institute.repository;

import com.example.institute.model.Notice;
import com.example.institute.model.NoticeRecipient;
import com.example.institute.model.Parent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface NoticeRecipientRepository extends JpaRepository<NoticeRecipient, Long> {
    
    List<NoticeRecipient> findByParentId(Long parentId);
    
    List<NoticeRecipient> findByParentIdOrderByDeliveredAtDesc(Long parentId);
    
    List<NoticeRecipient> findByNoticeId(Long noticeId);
    
    List<NoticeRecipient> findByStudentId(String studentId);
    
    List<NoticeRecipient> findByIsReadFalse();
    
    List<NoticeRecipient> findByParentIdAndIsReadFalse(Long parentId);
    
    @Query("SELECT nr FROM NoticeRecipient nr WHERE nr.parent.id = :parentId ORDER BY nr.deliveredAt DESC")
    List<NoticeRecipient> findNoticesForParent(@Param("parentId") Long parentId);
    
    @Query("SELECT COUNT(nr) FROM NoticeRecipient nr WHERE nr.parent.id = :parentId AND nr.isRead = false")
    long countUnreadNoticesForParent(@Param("parentId") Long parentId);
    
    @Query("SELECT nr FROM NoticeRecipient nr WHERE nr.notice.id = :noticeId AND nr.parent.id = :parentId")
    NoticeRecipient findByNoticeAndParent(@Param("noticeId") Long noticeId, @Param("parentId") Long parentId);
    
    @Modifying
    @Transactional
    @Query("UPDATE NoticeRecipient nr SET nr.isRead = true, nr.readAt = :readAt WHERE nr.id = :id")
    int markAsRead(@Param("id") Long id, @Param("readAt") LocalDateTime readAt);
    
    @Modifying
    @Transactional
    @Query("DELETE FROM NoticeRecipient nr WHERE nr.notice.id = :noticeId")
    void deleteByNoticeId(@Param("noticeId") Long noticeId);
}