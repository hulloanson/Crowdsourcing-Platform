<?php

namespace App\Notifications;

use App\BusinessLogicLayer\gamification\GamificationBadge;
use App\Models\ViewModels\GamificationBadgeVM;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;

class ReferredQuestionnaireAnswered extends BadgeActionOccured implements ShouldQueue
{
    use Queueable;

    private $questionnaire;
    private $badge;
    private $badgeVM;

    public function __construct($questionnaire, GamificationBadge $badge, GamificationBadgeVM $badgeVM)
    {
        parent::__construct($badgeVM,
            'Thank you for your referral!',
            'You are making an impact!',
            'Someone answered to a questionnaire you shared!<br>"' . $questionnaire->title . '".<br>',
            $badge->getEmailBody(),
            'Are you ready for the next challenge?',
            'Visit your dashboard and invite more friends'
        );
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param  mixed $notifiable
     * @return array
     */
    public function via($notifiable)
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param  mixed $notifiable
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    public function toMail($notifiable)
    {
        return parent::toMail($notifiable);
    }

    /**
     * Get the array representation of the notification.
     *
     * @param  mixed $notifiable
     * @return array
     */
    public function toArray($notifiable)
    {
        return [
            //
        ];
    }
}
