module EmailContentHelper

  SUPPRESSIONS = {
    :BOUNCE => 'bounces',
    :UNSUBSCRIBE => 'unsubscribes',
    :COMPLAINT => 'complaints'
  }

	TAGS = {
	  :ACTIVATION => 'activation'
	}

  EVENT_TYPES = {
    :OPENED => 'opened',
    :ACCEPTED => 'accepted'
  }

	SUBJECTS = {
	  :ACTIVATION => 'Activate your account',
    :ACTIVATION_REMINDER => 'Waiting to hear from you'
	}

	MESSAGES = {
    :ACTIVATION => 'Welcome %s, Please activate your account by clicking on %s',
    :ACTIVATION_REMINDER => " %s, We still haven't seen your account activated"
  }

  def self.getSubject(action, subject_vars)
  	if subject_vars.present?
    	return SUBJECTS[action] % subject_vars
    end
    return SUBJECTS[action]
  end

  def self.getMessage(action, text_vars)
  	if text_vars.present?
  	 return MESSAGES[action] % text_vars
  	end
  	return MESSAGES[action]
  end

  def self.getTags(tag)
  	return TAGS[tag]
  end

  def self.getSuppressionType(type)
    return SUPPRESSIONS[type]
  end

  def self.getEventType(type)
    return EVENT_TYPES[type]
  end

end