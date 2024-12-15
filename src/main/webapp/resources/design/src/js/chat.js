import utils from './utils';

/*-----------------------------------------------
|   Chat
-----------------------------------------------*/
const chatInit = () => {
  // DOM이 완전히 로드된 후에만 실행되도록 합니다
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeChat);
  } else {
    initializeChat();
  }
};

const initializeChat = () => {
  const Events = {
    CLICK: 'click',
    SHOWN_BS_TAB: 'shown.bs.tab',
    KEYUP: 'keyup',
    EMOJI: 'emoji'
  };

  const Selector = {
    CHAT_SIDEBAR: '.chat-sidebar',
    CHAT_CONTACT: '.chat-contact',
    CHAT_CONTENT_SCROLL_AREA: '.chat-content-scroll-area',
    CHAT_CONTENT_SCROLL_AREA_ACTIVE: '.card-chat-pane.active .chat-content-scroll-area',
    CHAT_EMOJIAREA: '.chat-editor-area .emojiarea-editor',
    BTN_SEND: '.btn-send',
    EMOJIEAREA_EDITOR: '.emojiarea-editor',
    BTN_INFO: '.btn-chat-info',
    CONVERSATION_INFO: '.conversation-info',
    CONTACTS_LIST_SHOW: '.contacts-list-show'
  };

  const ClassName = {
    UNREAD_MESSAGE: 'unread-message',
    TEXT_PRIMARY: 'text-primary',
    SHOW: 'show'
  };

  const DATA_KEY = {
    INDEX: 'index'
  };

  // 요소들이 존재하는지 확인
  const initElements = () => {
    const elements = {
      chatSidebar: document.querySelector(Selector.CHAT_SIDEBAR),
      chatContact: document.querySelectorAll(Selector.CHAT_CONTACT),
      chatEmojiarea: document.querySelector(Selector.CHAT_EMOJIAREA),
      btnSend: document.querySelector(Selector.BTN_SEND),
      currentChatArea: document.querySelector(Selector.CHAT_CONTENT_SCROLL_AREA),
      btnInfoList: document.querySelectorAll(Selector.BTN_INFO)
    };

    return elements;
  };

  const elements = initElements();

  // Set scrollbar position
  const setScrollbarPosition = $chatArea => {
    if ($chatArea) {
      const scrollArea = $chatArea;
      scrollArea.scrollTop = $chatArea.scrollHeight;
    }
  };

  // Initialize chat info buttons
  const initializeChatInfo = () => {
    const { btnInfoList } = elements;
    
    if (btnInfoList && btnInfoList.length > 0) {
      btnInfoList.forEach(btn => {
        btn.addEventListener(Events.CLICK, e => {
          e.preventDefault();  // 기본 동작 방지
          const $this = e.currentTarget;
          const dataIndex = $this.getAttribute('data-index');
          
          // Close all other conversation info panels
          document.querySelectorAll(Selector.CONVERSATION_INFO).forEach(info => {
            if (info.getAttribute('data-index') !== dataIndex) {
              info.classList.remove(ClassName.SHOW);
            }
          });
          
          // Toggle the clicked conversation info panel
          const $info = document.querySelector(
            `${Selector.CONVERSATION_INFO}[data-index="${dataIndex}"]`
          );
          
          if ($info) {
            $info.classList.toggle(ClassName.SHOW);
          }
        });
      });

      // Add click event listener to close info panel when clicking outside
      document.addEventListener('click', (e) => {
        if (!e.target.closest(Selector.BTN_INFO) && 
            !e.target.closest(Selector.CONVERSATION_INFO)) {
          document.querySelectorAll(Selector.CONVERSATION_INFO).forEach(info => {
            info.classList.remove(ClassName.SHOW);
          });
        }
      });
    }
  };

  // Initialize chat contacts
  const initializeChatContacts = () => {
    const { chatContact, chatSidebar } = elements;
    
    if (chatContact.length > 0) {
      chatContact.forEach(el => {
        el.addEventListener(Events.CLICK, e => {
          const $this = e.currentTarget;
          $this.classList.add('active');
          
          if (window.innerWidth < 768 && !e.target.classList.contains('hover-actions')) {
            chatSidebar && (chatSidebar.style.left = '-100%');
          }

          if ($this.classList.contains(ClassName.UNREAD_MESSAGE)) {
            $this.classList.remove(ClassName.UNREAD_MESSAGE);
          }
        });

        el.addEventListener(Events.SHOWN_BS_TAB, () => {
          const { chatEmojiarea, btnSend } = elements;
          if (chatEmojiarea) {
            chatEmojiarea.innerHTML = '';
            btnSend && btnSend.classList.remove(ClassName.TEXT_PRIMARY);
          }
          const TargetChatArea = document.querySelector(Selector.CHAT_CONTENT_SCROLL_AREA_ACTIVE);
          setScrollbarPosition(TargetChatArea);
        });
      });
    }
  };

  // Initialize emoji area
  const initializeEmojiArea = () => {
    const { chatEmojiarea, btnSend } = elements;
    
    if (chatEmojiarea) {
      chatEmojiarea.setAttribute('placeholder', 'Type your message');
      chatEmojiarea.addEventListener(Events.KEYUP, e => {
        if (e.target.textContent.length <= 0) {
          btnSend && btnSend.classList.remove(ClassName.TEXT_PRIMARY);
          if (e.target.innerHTML === '<br>') {
            e.target.innerHTML = '';
          }
        } else {
          btnSend && btnSend.classList.add(ClassName.TEXT_PRIMARY);
        }

        const TargetChatArea = document.querySelector(Selector.CHAT_CONTENT_SCROLL_AREA_ACTIVE);
        setScrollbarPosition(TargetChatArea);
      });
    }
  };

  // Initialize contacts list
  const initializeContactsList = () => {
    const { chatSidebar } = elements;
    
    document.querySelectorAll(Selector.CONTACTS_LIST_SHOW).forEach(el => {
      el.addEventListener(Events.CLICK, () => {
        chatSidebar && (chatSidebar.style.left = '0');
      });
    });
  };

  // Set initial scrollbar position
  setTimeout(() => {
    setScrollbarPosition(elements.currentChatArea);
  }, 700);

  // Initialize all features
  initializeChatInfo();
  initializeChatContacts();
  initializeEmojiArea();
  initializeContactsList();

  // Resize handler
  utils.resize(() => {
    const TargetChatArea = document.querySelector(Selector.CHAT_CONTENT_SCROLL_AREA_ACTIVE);
    setScrollbarPosition(TargetChatArea);
  });
};

export default chatInit;